package net.codestory;

import net.gageot.test.rules.ServiceRule;
import net.sourceforge.jwebunit.junit.WebTester;
import org.junit.Before;
import org.junit.Rule;

public abstract class AbstractPageTest extends WebTester {
  @Rule
  public ServiceRule<ContestServer> server = ServiceRule.startWithRandomPort(ContestServer.class);

  @Before
  public void setUp() {
    setBaseUrl("http://localhost:" + server.getPort());
  }
}