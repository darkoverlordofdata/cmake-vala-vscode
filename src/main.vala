
#if (EMSCRIPTEN)
/**
 * game
 * 
 * entry point for Emscripten
 * 
 * -s EXPORTED_FUNCTIONS='["_game"]'
 * Invoked by clicking on the start button in the browser
 *
 */
public void game() {
	var window = new Sdx.Ui.Window(720, 512, "ShmupWarz");
	var game = new Game(window);
	game.Start();
	Emscripten.SetMainLoopArg(MainLoop, game, 0, 1);
	Emscripten.SetMainLoopArg(MainLoop, null, 0, 1);
	return;
}
/**
 * the main loop
 */
public void MainLoop(void* arg) {
	Sdx.GameLoop((Game*)arg);
}


#else
/**
 * Start the game
 *
 */
public int main(string args[]) {
#if (ANDROID)
	var window = new Sdx.Ui.Window(1184, 768, "ShmupWarz");
	var game = new Game(window);
#else
	var window = new Sdx.Ui.Window(720, 512, "ShmupWarz");
	var game = new Game(window);
#endif
	game.Start();
	while (Sdx.running) {
		Sdx.GameLoop(game);
	}
	return 0;
}
#endif

