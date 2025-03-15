package MODEL;
/**
 * Represents a driver in the Mega City Cab system.
 */
public class Driver_Megacity {
    private String name;
    private String phoneNumber;
    private String nic;
    private String gender;
    private String address;
    private String licenseNumber;
    private int vehicleId;  // Vehicle ID field
    private String vehicleType;
    private String vehicleRegistrationNumber;
    private String vehicleMakeModel;
    private int userID;
    private int driverID;
    private String licensePlate;
    private String username;
private String password;
    
    // Constructor with all required fields (with driverID parameter)
    public Driver_Megacity(String name, String phoneNumber, String nic, String gender, String address, String licenseNumber, String vehicleType, String vehicleRegistrationNumber, String vehicleMakeModel, int driverID) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.nic = nic;
        this.gender = gender;
        this.address = address;
        this.licenseNumber = licenseNumber;
        this.vehicleType = vehicleType;
        this.vehicleRegistrationNumber = vehicleRegistrationNumber;
        this.vehicleMakeModel = vehicleMakeModel;
        this.driverID = driverID;
    }
       public Driver_Megacity() {
        // Empty constructor - properties will be set using setters
    }
    
    // Additional constructor without driverID parameter (for new drivers)
    public Driver_Megacity(String name, String phoneNumber, String nic, String gender, String address, String licenseNumber, String vehicleType, String vehicleRegistrationNumber, String vehicleMakeModel) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.nic = nic;
        this.gender = gender;
        this.address = address;
        this.licenseNumber = licenseNumber;
        this.vehicleType = vehicleType;
        this.vehicleRegistrationNumber = vehicleRegistrationNumber;
        this.vehicleMakeModel = vehicleMakeModel;
        // driverID will be set later or assigned by database
    }
  
    // Getters and Setters for all fields
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    public String getNic() {
        return nic;
    }
    
    public void setNic(String nic) {
        this.nic = nic;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getLicenseNumber() {
        return licenseNumber;
    }
    
    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
    
    // Getter and Setter for vehicleId
    public int getVehicleId() {
        return vehicleId;
    }
    
    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }
    
    public String getVehicleType() {
        return vehicleType;
    }
    
    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }
    
    public String getVehicleRegistrationNumber() {
        return vehicleRegistrationNumber;
    }
    
    public void setVehicleRegistrationNumber(String vehicleRegistrationNumber) {
        this.vehicleRegistrationNumber = vehicleRegistrationNumber;
    }
    
    public String getVehicleMakeModel() {
        return vehicleMakeModel;
    }
    
    public void setVehicleMakeModel(String vehicleMakeModel) {
        this.vehicleMakeModel = vehicleMakeModel;
    }

    public String getLicensePlate() {
        return licensePlate;
    }
    
    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }
    
    public int getUserID() {
        return userID;
    }
    
    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    public int getDriverId() {
        return driverID;
    }
    
    public void setDriverId(int driverID) {
        this.driverID = driverID;
    }
    public String getUsername() {
    return username;
}

public void setUsername(String username) {
    this.username = username;
}

public String getPassword() {
    return password;
}

public void setPassword(String password) {
    this.password = password;
}
}