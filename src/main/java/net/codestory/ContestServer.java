package net.codestory;

import com.google.common.io.Files;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.File;
import java.io.IOException;
import java.net.InetSocketAddress;

public class ContestServer implements HttpHandler {
  private HttpServer server;

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    byte[] response = Files.toByteArray(new File("web/index.html"));

    exchange.sendResponseHeaders(200, response.length);
    exchange.getResponseBody().write(response);
    exchange.close();
  }

  public void start(int port) throws IOException {
    server = HttpServer.create(new InetSocketAddress(port), 0);
    server.createContext("/", this);
    server.start();
  }

  public void stop() {
    server.stop(0);
  }
}
