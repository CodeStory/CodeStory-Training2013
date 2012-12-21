package net.codestory;

import net.gageot.test.rules.ServiceRule;
import net.sourceforge.jwebunit.junit.WebTester;
import org.junit.Rule;
import org.junit.Test;

public class ContestServerTest extends WebTester {
  @Rule
  public ServiceRule<ContestServer> server = ServiceRule.startWithRandomPort(ContestServer.class);

  @Test
  public void should_display_welcome() {
    setBaseUrl("http://localhost:" + server.getPort());

    beginAt("/");

    assertTextPresent("Welcome");
  }
}
