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
  private static final SimpleDateFormat DATE = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss.000'Z'");

  public static void main(String[] args) throws Exception {
    List<Participant> participants = Lists.newArrayList();

    for (File file : new File("logins").listFiles(STANDARD_FILES)) {
      String login = file.getName();

      int level = file.listFiles(STANDARD_FILES).length;
      String time = DATE.format(file.lastModified());

      String gravatar = null;
      if (new File(file, "email").exists()) {
        String email = Files.readFirstLine(new File(file, "email"), Charsets.UTF_8);
        String hash = Hashing.md5().hashString(email, Charsets.UTF_8).toString();
        gravatar = "http://www.gravatar.com/avatar/" + hash + "/?s=64";
      }

      participants.add(new Participant(login, level, time, gravatar));
    }


    String json = new GsonBuilder().setPrettyPrinting().create().toJson(participants);
    System.out.println(json);
  }

  public static class Participant {
    public String name;
    public int level;
    public String time;
    public String gravatar;

    public Participant(String name, int level, String time, String gravatar) {
      this.name = name;
      this.level = level;
      this.time = time;
      this.gravatar = gravatar;
    }
  }
}
