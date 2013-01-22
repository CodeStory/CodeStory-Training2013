package codestory;

import org.junit.Test;

import java.io.File;
import java.net.URISyntaxException;
import java.util.Date;

import static org.fest.assertions.Assertions.assertThat;
import static org.fest.assertions.MapAssert.entry;

public class GraphGeneratorTest {

    @Test
    public void should_update_scores() throws Exception {
        Date date = new Date();

        Logins logins = new GraphGenerator().update(date, directory("tree")).logins();

        assertThat(logins).containsOnly(new Login("login1"), new Login("login2"));

        assertThat(logins.login("login1").score()).isEqualTo(2);
        assertThat(logins.login("login1").scores()).hasSize(1).includes(entry(date, 2));

        assertThat(logins.login("login2").score()).isEqualTo(0);
        assertThat(logins.login("login2").scores()).hasSize(1).includes(entry(date, 0));
    }

    @Test
    public void should_get_same_scores() throws Exception {
        Date date = new Date();

        Logins logins = new GraphGenerator().update(date, directory("tree-with-same-score")).logins();

        assertThat(logins).containsOnly(new Login("login1"), new Login("login2"));

        assertThat(logins.login("login1").score()).isEqualTo(1);
        assertThat(logins.login("login1").scores()).hasSize(1).includes(entry(date, 1));

        assertThat(logins.login("login2").score()).isEqualTo(1);
        assertThat(logins.login("login2").scores()).hasSize(1).includes(entry(date, 1));
    }

    @Test
    public void should_update_twice() throws Exception {
        Date date1 = new Date();
        Date date2 = new Date(date1.getTime() + 1000);

        Logins logins = new GraphGenerator()
                .update(date1, directory("tree-with-same-score"))
                .update(date2, directory("tree"))
                .logins();

        assertThat(logins).containsOnly(new Login("login1"), new Login("login2"));

        assertThat(logins.login("login1").score()).isEqualTo(2);
        assertThat(logins.login("login1").scores()).hasSize(2).includes(entry(date1, 1), entry(date2, 2));

        assertThat(logins.login("login2").score()).isEqualTo(0);
        assertThat(logins.login("login2").scores()).hasSize(2).includes(entry(date1, 1), entry(date2, 0));
    }

    private static File directory(String directoryName) throws URISyntaxException {
        return new File(GraphGeneratorTest.class.getResource("/" + directoryName).toURI());
    }

}
