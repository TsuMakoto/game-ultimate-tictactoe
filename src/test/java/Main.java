import com.codingame.gameengine.runner.MultiplayerGameRunner;

public class Main {
    public static void main(String[] args) {

        MultiplayerGameRunner gameRunner = new MultiplayerGameRunner();
        gameRunner.addAgent(Player1.class);
        gameRunner.addAgent(Player2.class);

        // gameRunner.addAgent("python3 /home/user/player.py");

        gameRunner.start(3000);
    }
}
