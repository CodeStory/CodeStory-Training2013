import java.util.Arrays;

public class Trip {
  private final Flight[] flights;
  private final int[] nextCompat;
  private final int[] cache;

  public Trip(String input) {
    this(FlightsForString.forString(input));
  }

  public Trip(Flight[] flights) {
    Arrays.sort(flights);
    this.flights = flights;
    this.nextCompat = nextCompat(flights);
    this.cache = cache(flights);
  }

  private static int[] cache(Flight[] flights) {
    int[] cache = new int[flights.length];
    Arrays.fill(cache, -1);
    return cache;
  }

  private static int[] nextCompat(Flight[] flights) {
    int[] nextCompat = new int[flights.length];
    Arrays.fill(nextCompat, -1);

    for (int i = 0; i < flights.length; i++) {
      Flight flight = flights[i];

      for (int j = i + 1; j < flights.length; j++) {
        Flight otherFlight = flights[j];

        if (otherFlight.takeOff >= flight.landing) {
          nextCompat[i] = j;
          break;
        }
      }
    }

    return nextCompat;
  }

  public int gain() {
    int count = flights.length;
    if (count == 0) {
      return 0;
    }

    for (int i = count - 1; i >= 0; i--) {
      int gainWithFlight = flights[i].gain + (-1 == nextCompat[i] ? 0 : cache[nextCompat[i]]);
      int gainWithoutFlight = ((i + 1) < count) ? cache[i + 1] : 0;
      cache[i] = Math.max(gainWithoutFlight, gainWithFlight);
    }

    return cache[0];
  }
}
