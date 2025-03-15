package MODEL;

/**
 * Represents a vehicle in the Mega City Cab system.
 */
public class Vehicle_Megacity {
    private int vehicleId;
    private String licensePlate;
    private String model;
    private String vehicleType;
    
    // Constructor
    public Vehicle_Megacity(String licensePlate, String model, String vehicleType) {
        this.licensePlate = licensePlate;
        this.model = model;
        this.vehicleType = vehicleType;
    }
    
    // Constructor with vehicleId
    public Vehicle_Megacity(int vehicleId, String licensePlate, String model, String vehicleType) {
        this.vehicleId = vehicleId;
        this.licensePlate = licensePlate;
        this.model = model;
        this.vehicleType = vehicleType;
    }
    
    // Getters and Setters
    public int getVehicleId() {
        return vehicleId;
    }
    
    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }
    
    public String getLicensePlate() {
        return licensePlate;
    }
    
    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }
    
    public String getModel() {
        return model;
    }
    
    public void setModel(String model) {
        this.model = model;
    }
    
    public String getVehicleType() {
        return vehicleType;
    }
    
    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }
}