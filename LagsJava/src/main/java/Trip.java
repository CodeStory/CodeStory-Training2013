import java.util.Arrays;

public class Trip {
  private final Flight[] flights;

  public Trip(Flight[] flights) {
    Arrays.sort(flights);
    this.flights = flights;
  }

  public Trip(String input) {
    this(FlightsForString.forString(input));
  }

  public int gain() {
    return gain(0, 0);
  }

  private int gain(int index, int maxLanding) {
    if (index == flights.length) {
      return 0;
    }

    Flight flight = flights[index];

    int gainWithoutFlight = gain(index + 1, maxLanding);
    if (maxLanding > flight.takeOff) {
      return gainWithoutFlight;
    }

    int gainWithFlight = gain(index + 1, flight.landing);
    return Math.max(gainWithoutFlight, flight.gain + gainWithFlight);
  }
}
