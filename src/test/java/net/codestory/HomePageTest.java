package net.codestory;

import org.junit.Test;

public class HomePageTest extends AbstractPageTest {
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
  }

  @Test
  public void should_not_sign_up_yet() {
    beginAt("/");

    assertLinkPresentWithExactText("Registration opening soon!");
  }

  @Test
  public void should_go_to_faq() {
    beginAt("/");

    clickLinkWithText("Let's try to answer");
    assertTitleEquals("Code-Story - F.A.Q.");
  }
}
