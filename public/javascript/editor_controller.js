(() => {
  stimulus.register("editor", class extends Stimulus.Controller {
    static get targets() {
      return [ "container" ]
    }
    connect() {
      const self = this
      require.config({ paths: { vs: '/vendor/vs' } });
			require(['vs/editor/editor.main'], function () {
				this.editor = monaco.editor.create(self.containerTarget, {
					value: [
            'class Player\n  def play_turn(warrior)\n    # ajouter votre code ici\n  end\nend'
          ].join('\n'),
					language: 'ruby',
          theme: 'vs-dark',
          minimap: { enabled: false }
				});
			});
    }
  })
})()
