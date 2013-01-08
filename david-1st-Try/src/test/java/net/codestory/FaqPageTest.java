package net.codestory;

import org.junit.Test;

public class FaqPageTest extends AbstractPageTest {
  @Test
  public void should_display_on_progress_faq() {
    beginAt("/faq");

    assertTextPresent("To be done");
  }
}
