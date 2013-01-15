public class Flight implements Comparable<Flight> {
  int takeOff;
  int landing;
  int gain;

  Flight(int takeOff, int landing, int gain) {
    this.takeOff = takeOff;
    this.landing = landing;
    this.gain = gain;
  }

  @Override
  public int compareTo(Flight flight) {
    return takeOff - flight.takeOff;
  }
}