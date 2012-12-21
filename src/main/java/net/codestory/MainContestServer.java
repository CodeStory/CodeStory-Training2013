package net.codestory;

import java.io.IOException;

public class MainContestServer {
  public static void main(String[] args) throws IOException {
    new ContestServer().start(8080);
  }
}
