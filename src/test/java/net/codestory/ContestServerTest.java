package net.codestory;

import net.gageot.test.rules.ServiceRule;
import net.sourceforge.jwebunit.junit.WebTester;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;

public class ContestServerTest extends WebTester {
  @Rule
  public ServiceRule<ContestServer> server = ServiceRule.startWithRandomPort(ContestServer.class);

  @Before
  public void setUp() {
    setBaseUrl("http://localhost:" + server.getPort());
  }

  @Test
  public void should_display_welcome() {
    beginAt("/");

    assertTextPresent("Welcome");
    assertTextPresent("to our 2013 Contest");
  }

  @Test
  public void should_display_links() {
    beginAt("/");

    assertLinkPresentWithExactText("Home");
    assertLinkPresentWithExactText("Blog");
    assertLinkPresentWithExactText("Contact");
  }

  @Test
  public void should_sign_up() {
    beginAt("/");

    assertLinkPresentWithExactText("Sign up today");
  }
}
