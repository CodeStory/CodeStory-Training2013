package net.codestory;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.net.InetSocketAddress;

public class ContestServer implements HttpHandler {
  private HttpServer server;

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String body = "Welcome";

    byte[] response = body.getBytes();
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
