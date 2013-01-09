import com.google.common.base.Function;
import com.google.common.base.Objects;
import com.google.common.collect.Iterables;
import com.google.common.collect.Lists;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.util.Collections;
import java.util.List;

import static com.google.common.base.Predicates.equalTo;
import static com.google.common.collect.ImmutableList.copyOf;
import static com.google.common.collect.Iterables.concat;
import static com.google.common.collect.Iterables.cycle;
import static com.google.common.collect.Iterables.limit;
import static com.google.common.collect.Lists.newArrayList;
import static java.lang.Integer.parseInt;
import static net.gageot.listmaker.ListMaker.with;

public class Scalaskel {
  public static final int FOO = 1;
  public static final int BAR = 7;
  public static final int QIX = 11;
  public static final int BAZ = 17;

  public String json(int cents) {
    return toJson(combinations(cents));
  }

  public static class FooBarQixBaz implements Comparable<FooBarQixBaz> {
    public Integer foo;
    public Integer bar;
    public Integer qix;
    public Integer baz;

    @Override
    public int compareTo(FooBarQixBaz other) {
      int diff = Objects.firstNonNull(foo, 0) - Objects.firstNonNull(other.foo, 0);
      if (diff != 0) {
        return diff;
      }

      diff = Objects.firstNonNull(bar, 0) - Objects.firstNonNull(other.bar, 0);
      if (diff != 0) {
        return diff;
      }

      diff = Objects.firstNonNull(qix, 0) - Objects.firstNonNull(other.qix, 0);
      if (diff != 0) {
        return diff;
      }

      diff = Objects.firstNonNull(baz, 0) - Objects.firstNonNull(other.baz, 0);
      if (diff != 0) {
        return diff;
      }

      return 0;
    }
  }

  private static String toJson(List<List<Integer>> combinations) {
    return new GsonBuilder().create().toJson(with(combinations).to(new Function<List<Integer>, FooBarQixBaz>() {
      @Override
      public FooBarQixBaz apply(List<Integer> combination) {
        FooBarQixBaz fooBarQixBaz = new FooBarQixBaz();
        fooBarQixBaz.foo = zeroToNull(with(combination).count(equalTo(FOO)));
        fooBarQixBaz.bar = zeroToNull(with(combination).count(equalTo(BAR)));
        fooBarQixBaz.qix = zeroToNull(with(combination).count(equalTo(QIX)));
        fooBarQixBaz.baz = zeroToNull(with(combination).count(equalTo(BAZ)));
        return fooBarQixBaz;
      }

      private Integer zeroToNull(int count) {
        return (count == 0) ? null : count;
      }
    }).toList());
  }

  private List<List<Integer>> combinations(int cents) {
    List<List<Integer>> combinations = newArrayList();
    addCombinations(0, 0, 0, cents, BAZ, combinations);
    return combinations;
  }

  private void addCombinations(int quarters, int dimes, int nickels, int pennies, int useCoinsUpTo, List<List<Integer>> combinations) {
    if ((pennies >= BAZ) && (useCoinsUpTo >= BAZ)) {
      addCombinations(quarters + 1, dimes, nickels, pennies - BAZ, BAZ, combinations);
    }

    if ((pennies >= QIX) && (useCoinsUpTo >= QIX)) {
      addCombinations(quarters, dimes + 1, nickels, pennies - QIX, QIX, combinations);
    }

    if ((pennies >= BAR) && (useCoinsUpTo >= BAR)) {
      addCombinations(quarters, dimes, nickels + 1, pennies - BAR, BAR, combinations);
    }

    combinations.add(copyOf(concat(
      limit(cycle(BAZ), quarters),
      limit(cycle(QIX), dimes),
      limit(cycle(BAR), nickels),
      limit(cycle(FOO), pennies))));
  }

  public static void main(String[] args) throws Exception {
    int cents = parseInt(args[0]);
    String json = args[1];

    try {
      String expected = new Scalaskel().json(cents);
      String actual = toJson(toCombinations(json));

      if (expected.equals(actual)) {
        System.out.println("OK");
      } else {
        System.out.println("KO");
      }
    } catch (Exception e) {
      System.out.println("KO");
    }
  }

  static List<List<Integer>> toCombinations(String json) {
    List<List<Integer>> combinations = Lists.newArrayList();

    TypeToken<List<FooBarQixBaz>> type = new TypeToken<List<FooBarQixBaz>>() {
    };

    List<FooBarQixBaz> fooBarQixBazs = (List<FooBarQixBaz>) new Gson().fromJson(json, type.getType());
    Collections.sort(fooBarQixBazs);

    for (FooBarQixBaz composition : fooBarQixBazs) {
      int baz = Objects.firstNonNull(composition.baz, 0);
      int qix = Objects.firstNonNull(composition.qix, 0);
      int bar = Objects.firstNonNull(composition.bar, 0);
      int foo = Objects.firstNonNull(composition.foo, 0);

      List<Integer> combination = Lists.newArrayList();
      Iterables.addAll(combination, limit(cycle(Scalaskel.BAZ), baz));
      Iterables.addAll(combination, limit(cycle(Scalaskel.QIX), qix));
      Iterables.addAll(combination, limit(cycle(Scalaskel.BAR), bar));
      Iterables.addAll(combination, limit(cycle(Scalaskel.FOO), foo));

      combinations.add(combination);
    }

    return combinations;
  }
}