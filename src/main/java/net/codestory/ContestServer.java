package net.codestory;

import com.google.common.base.Charsets;
import com.google.common.base.Throwables;
import com.google.common.io.Files;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import net.codestory.templating.ContentWithVariables;
import net.codestory.templating.Layout;
import net.codestory.templating.Template;
import net.codestory.templating.YamlFrontMatter;

import java.io.File;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.Map;

public class ContestServer implements HttpHandler {
  private HttpServer server;

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String path = exchange.getRequestURI().getPath();

    System.out.println(path);

    String body;
    if (path.equals("/faq")) {
      body = templatize(read("faq.html"));
    } else {
      body = templatize(read("index.html"));
    }

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

  private String templatize(String text) {
    ContentWithVariables yaml = new YamlFrontMatter().parse(text);
    String content = yaml.getContent();
    Map<String, String> variables = yaml.getVariables();

    String layout = variables.get("layout");
    if (layout != null) {
      content = new Layout(read(layout)).apply(content);
    }

    return new Template().apply(content, variables);
  }

  private String read(String path) {
    return read(file(path));
  }

  private String read(File file) {
    try {
      return Files.toString(file, Charsets.UTF_8);
    } catch (IOException e) {
      throw Throwables.propagate(e);
    }
  }

  private File file(String path) {
    if (path.endsWith("/")) {
      throw new IllegalStateException("Not found");
    }

    try {
      File root = new File("web");
      File file = new File(root, path);
      if (!file.exists() || !file.getCanonicalPath().startsWith(root.getCanonicalPath())) {
        throw new IllegalStateException("Not found");
      }

      return file;
    } catch (IOException e) {
      throw Throwables.propagate(e);
    }
  }
}
