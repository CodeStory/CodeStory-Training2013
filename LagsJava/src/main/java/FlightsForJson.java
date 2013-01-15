import com.google.common.collect.Lists;
import com.google.gson.Gson;
import com.google.gson.internal.StringMap;

import java.util.List;

public class FlightsForJson {
  public static Flight[] forJson(String json) {
    List<Flight> flights = Lists.newArrayList();

    for (StringMap map : (List<StringMap>) new Gson().fromJson(json, List.class)) {
      int takeOff = ((Number) map.get("start")).intValue();
      int landing = takeOff + ((Number) map.get("length")).intValue();
      int gain = ((Number) map.get("price")).intValue();

      flights.add(new Flight(takeOff, landing, gain));
    }

    return flights.toArray(new Flight[flights.size()]);
  }
}
