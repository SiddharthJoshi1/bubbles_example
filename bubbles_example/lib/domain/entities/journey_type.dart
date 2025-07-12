/// Represents the different stages or "bubbles" within a delivery journey.
///
/// Each enum value corresponds to a distinct part of the user's flow
/// through the delivery process.
enum Bubbles {
  /// The initial stage where items are selected and reviewed.
  basket,

  /// The stage where delivery address details are entered and confirmed.
  deliverydetails,

  /// The stage where payment information is provided and processed.
  payment,

  /// The final stage indicating the successful completion of the journey.
  completed
}
