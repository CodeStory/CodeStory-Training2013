package codestory;

import org.junit.Test;

import java.io.File;
import java.util.Date;

import static java.io.File.separator;
import static org.fest.assertions.Assertions.assertThat;

public class LoginsTest {

    @Test
    public void should_compute_scores() throws Exception {
        final Logins logins = new Logins().update(
                new Date(),
                new File(getClass().getResource(separator + "tree" + separator + "logins").toURI()),
                new Steps("step1", "step2"));

        assertThat(logins).hasSize(2);
        assertThat(logins.login("login1").score()).isEqualTo(2);
        assertThat(logins.login("login2").score()).isEqualTo(0);
    }
}
