import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import com.codingame.gameengine.runner.MultiplayerGameRunner;
import com.codingame.gameengine.runner.dto.GameResult;
import com.google.gson.Gson;

public class Simulator {
    public static void main(String[] args) {

        MultiplayerGameRunner gameRunner = new MultiplayerGameRunner();
        gameRunner.addAgent("julia /app/src/test/ruby/player.jl", "Ruby agent", "/app/src/test/julia/ruby-agent.png");
        gameRunner.addAgent("julia /app/src/test/julia/player.jl", "Julia agent", "/app/src/test/julia/julia-agent.png");
        // gameRunner.addAgent("python3 /home/user/player.py");

        GameResult result = gameRunner.simulate();
        String json = new Gson().toJson(result);

        File file = new File("/tmp/codingame/game.json");

        try {
            FileWriter fileWriter = new FileWriter(file);
            fileWriter.write(json);
            fileWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
