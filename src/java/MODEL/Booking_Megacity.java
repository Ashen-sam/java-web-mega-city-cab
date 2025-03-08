package MODEL;

public class Booking_Megacity {

    private int bookingId;
    private int customerRegId;
    private int vehicleId;
    private String pickupLocation;
    private String dropLocation;
    private String bookingDate;
    private String bookingTime;
    private double price;
    private String status;

    // Default Constructor
    public Booking_Megacity() {
    }

    // Parameterized Constructor
    public Booking_Megacity(int bookingId, int customerRegId, int vehicleId, String pickupLocation,
            String dropLocation, String bookingDate, String bookingTime, double price, String status) {
        this.bookingId = bookingId;
        this.customerRegId = customerRegId;
        this.vehicleId = vehicleId;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.bookingDate = bookingDate;
        this.bookingTime = bookingTime;
        this.price = price;
        this.status = status;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getCustomerRegId() {
        return customerRegId;
    }

    public void setCustomerRegId(int customerRegId) {
        this.customerRegId = customerRegId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDropLocation() {
        return dropLocation;
    }

    public void setDropLocation(String dropLocation) {
        this.dropLocation = dropLocation;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(String bookingTime) {
        this.bookingTime = bookingTime;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Override toString() method for better readability
    @Override
    public String toString() {
        return "Booking_Megacity{"
                + "bookingId=" + bookingId
                + ", customerRegId=" + customerRegId
                + ", vehicleId=" + vehicleId
                + ", pickupLocation='" + pickupLocation + '\''
                + ", dropLocation='" + dropLocation + '\''
                + ", bookingDate='" + bookingDate + '\''
                + ", bookingTime='" + bookingTime + '\''
                + ", price=" + price
                + ", status='" + status + '\''
                + '}';
    }
}
