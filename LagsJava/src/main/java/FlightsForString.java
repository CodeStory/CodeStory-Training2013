import com.google.common.base.Function;
import com.google.common.base.Splitter;

import static java.lang.Integer.parseInt;
import static net.gageot.listmaker.ListMaker.with;

public class FlightsForString {
  private static final Splitter ON_NEW_LINE = Splitter.on('\n').omitEmptyStrings();

  public static Flight[] forString(String input) {
    Iterable<String> descriptions = ON_NEW_LINE.split(input);

    Flight[] flights = with(descriptions).to(new Function<String, Flight>() {
      @Override
      public Flight apply(String description) {
        String[] parts = description.split("[ ]");

        int takeOff = parseInt(parts[1]);
        int landing = takeOff + parseInt(parts[2]);
        int gain = parseInt(parts[3]);

        return new Flight(takeOff, landing, gain);
      }
    }).toArray(Flight.class);

    return flights;
  }
}
