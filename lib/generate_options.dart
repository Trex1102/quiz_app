import 'dart:math';

class GenerateOptions {

  static List<String> generateOptions(double answer) {
    final List<String> options = [];

    // Generate three random values close to the answer
    for (int i = 0; i < 3; i++) {
      double offset = Random().nextDouble() * answer *
          0.2; // Generate a random offset up to 20% of the answer
      double option = answer + (Random().nextBool()
          ? offset
          : -offset); // Add or subtract the offset randomly
      options.add(
          option.toStringAsFixed(1)); // Add the option to the list of strings
    }

    // Add the correct answer as one of the options
    options.add(answer.toStringAsFixed(1));

    // Shuffle the options randomly
    options.shuffle();

    return options;
  }
}
