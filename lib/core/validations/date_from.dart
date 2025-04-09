abstract class DateFrom {
  static String handleDateFrom({
    required DateTime date,
  }) {
    var now = DateTime.now();
    var diff = now.difference(
        date); // Calculate the difference from the given date to now

    if (diff.inMinutes < 1) {
      return "Now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    } else if (diff.inDays < 30) {
      int weeks = (diff.inDays / 7).floor();
      return "${weeks} ${weeks == 1 ? "week" : "weeks"} ago";
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return "${months} ${months == 1 ? "month" : "months"} ago";
    } else {
      int years = (diff.inDays / 365).floor();
      return "${years} ${years == 1 ? "year" : "years"} ago";
    }
  }
}
