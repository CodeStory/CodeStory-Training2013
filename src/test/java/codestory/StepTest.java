package codestory;

import org.junit.Test;

import java.io.File;

public class StepTest {

    @Test(expected = IllegalArgumentException.class)
    public void should_not_create_Step_if_filename_is_not_compliant() throws Exception {
        new Step(new File("03-not-a-step"));
    }

}
