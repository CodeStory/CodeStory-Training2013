package net.codestory;

import java.io.IOException;

import static com.google.common.base.Objects.firstNonNull;
import static java.lang.Integer.parseInt;

public class MainContestServer {
  public static void main(String[] args) throws IOException {
    int port = parseInt(firstNonNull(System.getenv("PORT"), "8080"));

    new ContestServer().start(port);
  }
}
