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
    private String vehicleType;
    private String vehicleRegistrationNumber;
    private String vehicleMakeModel;

    // Constructor with all fields
    public Driver_Megacity(String name, String phoneNumber, String nic, String gender, String address, 
                           String licenseNumber, String vehicleType, 
                           String vehicleRegistrationNumber, String vehicleMakeModel) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.nic = nic;
        this.gender = gender;
        this.address = address;
        this.licenseNumber = licenseNumber;
        this.vehicleType = vehicleType;
        this.vehicleRegistrationNumber = vehicleRegistrationNumber;
        this.vehicleMakeModel = vehicleMakeModel;
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
}
