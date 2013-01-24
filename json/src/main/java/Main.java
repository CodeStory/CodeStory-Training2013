import com.google.common.base.Charsets;
import com.google.common.collect.Lists;
import com.google.common.hash.Hashing;
import com.google.common.io.Files;
import com.google.common.io.PatternFilenameFilter;
import com.google.gson.GsonBuilder;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;

public class Main {
  private static final PatternFilenameFilter STANDARD_FILES = new PatternFilenameFilter("[^\\.]+.*");
  private static final SimpleDateFormat DATE = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.000");

  public static void main(String[] args) throws Exception {
    List<Participant> participants = Lists.newArrayList();

    int maxLevel = 2 + new File("scripts/steps").listFiles(STANDARD_FILES).length;

    for (File file : new File("logins").listFiles(STANDARD_FILES)) {
      String login = file.getName();

      int level = file.listFiles(STANDARD_FILES).length;
      String time = DATE.format(file.lastModified()) + "+0100";
      int perf = 0;
      if (new File(file, "jajascript-8").exists()) {
        perf = Integer.parseInt(Files.readFirstLine(new File(file, "jajascript-8"), Charsets.UTF_8));
      }

      String gravatar = null;
      if (new File(file, "email").exists()) {
        String email = Files.readFirstLine(new File(file, "email"), Charsets.UTF_8);
        String hash = Hashing.md5().hashString(email, Charsets.UTF_8).toString();
        gravatar = "http://www.gravatar.com/avatar/" + hash + "?s=64";
      }

      participants.add(new Participant(login, level, maxLevel, time, gravatar, perf, 10000));
    }

    String json = new GsonBuilder().setPrettyPrinting().create().toJson(participants);
    System.out.println(json);
  }

  public static class Participant {
    public String name;
    public int level;
    public int maxLevel;
    public String time;
    public String gravatar;
    public int perf;
    public int maxPerf;

    public Participant(String name, int level, int maxLevel, String time, String gravatar, int perf, int maxPerf) {
      this.name = name;
      this.level = level;
      this.maxLevel = maxLevel;
      this.time = time;
      this.gravatar = gravatar;
      this.perf = perf;
      this.maxPerf = maxPerf;
    }
  }
}
