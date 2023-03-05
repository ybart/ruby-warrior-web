(() => {
  stimulus.register("scene", class extends Stimulus.Controller {
    static get targets() {
      return [ "container" ]
    }

    connect() {
      this.objects = {};

      this.app = new PIXI.Application({
        resizeTo: this.containerTarget
      });

      this.containerTarget.appendChild(this.app.view);
      this.drawLevel();
    }

    walk() {
      const heroData = this.objects['@'];
      const position = heroData.position;
      if (heroData.position.x >= this.cols - 1) { return }

      heroData.animation = {
        progress: 0,
        duration: 20,
        startX: position.x * this.blockSize,
        startY: position.y * this.blockSize,
        endX: (position.x + 1) * this.blockSize,
        endY: position.y * this.blockSize
      }
      this.app.ticker.add(this.animateHero, this)

      heroData.position.x += 1;
    }

    animateHero(delta) {
      const heroData = this.objects['@']
      const animation = heroData.animation

      if (!animation) { return }

      const cell = heroData.cell
      const duration = animation.duration
      const startX = animation.startX
      const startY = animation.startY
      const endX = animation.endX
      const endY = animation.endY

      animation.progress = Math.min(animation.progress + delta, duration)

      cell.x = startX + animation.progress * (endX - startX) / duration
      cell.y = startY + animation.progress * (endY - startY) / duration

      if (animation.progress >= duration) {
        this.app.ticker.remove(this.animateHero, this)
        heroData.animation = null
      }
    }

    drawLevel() {
      const levelData = [
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['@', ' ', ' ', ' ', ' ', ' ', '- ','>'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
      ]

      this.rows = levelData.length;
      this.cols = levelData[0].length;

      this.blockSize = Math.min(
        Math.floor(this.app.screen.width / this.cols),
        Math.floor(this.app.screen.height / this.rows)
      )

      // TODO: leftMargin, topMargin

      while(this.app.stage.children[0]) {
        this.app.stage.removeChild(this.app.stage.children[0]);
      }

      // TODO: DRY
      for (const [y, row] of levelData.entries()) {
        for (const [x, char] of row.entries()) {
          const cell = this.backgroundCellFor(char)
          if (!cell) { continue; }
          this.setCellGeometry(cell, x, y)
          this.app.stage.addChild(cell)
        }
      }

      for (const [y, row] of levelData.entries()) {
        for (const [x, char] of row.entries()) {
          const cell = this.foregroundCellFor(char)
          if (!cell) { continue; }
          this.objects[char] = { position: { x: x, y: y }, cell: cell };
          this.setCellGeometry(cell, x, y)
          this.app.stage.addChild(cell)
        }
      }
      this.app.stage.addChild(this.objects['@'].cell)
    }

    backgroundCellFor(char) {
      switch (char) {
        case '-':
          return PIXI.Sprite.from('/images/wall.png');

        default:
          return PIXI.Sprite.from('/images/floor.png');
      }
    }

    foregroundCellFor(char) {
      switch (char) {
        case '@':
          return PIXI.Sprite.from('/images/spartacus.png');
        case '>':
          return PIXI.Sprite.from('/images/stairs.png');

        default:
          return null;
      }
    }

    setCellGeometry(cell, x, y) {
      cell.x = x * this.blockSize;
      cell.y = y * this.blockSize;
      cell.width = this.blockSize;
      cell.height = this.blockSize;
    }

    // setObject(cell, x, y) {
    //   if (this.objects[x] === undefined) {
    //     this.objects[x] = []
    //   }
    //   this.object[x][y] = cell
    // }
  })
})()
