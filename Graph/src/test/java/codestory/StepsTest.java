package codestory;

import org.junit.Test;

import java.io.File;

import static java.io.File.separator;
import static org.fest.assertions.Assertions.assertThat;

public class StepsTest {

    @Test
    public void should_get_correct_steps() throws Exception {
        String directoryName = separator + "tree" + separator + "scripts" + separator + "steps";

        Steps steps = new Steps(new File(getClass().getResource(directoryName).toURI()));

        assertThat(steps)
                .hasSize(2)
                .containsOnly(new Step(1, "step1"), new Step(2, "step2"));
    }

}
