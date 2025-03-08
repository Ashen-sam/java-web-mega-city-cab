/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package MODEL;

/**
 *
 * @author Ashen Samarasekera
 */
public class User_Megacity {

    private String username;
    private String password;
    private String role;
    private int userID;

    public User_Megacity (String username, String password, String role) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.userID = userID;
    }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public int getuserID() { return userID; }
    public void setuserID(int userID) { this.userID = userID; }
}
