package vn.hcmuaf.fit.drillsell.model;

public class UserGoogleDto {

    private String id;

    private String email;

    private boolean verifiedEmail;

    private String name;

    private String givenName;

    private String familyName;

    private String picture;

    public UserGoogleDto() {
    }

    public UserGoogleDto(String id, String email, boolean verifiedEmail, String name, String givenName, String familyName, String picture) {
        this.id = id;
        this.email = email;
        this.verifiedEmail = verifiedEmail;
        this.name = name;
        this.givenName = givenName;
        this.familyName = familyName;
        this.picture = picture;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isVerifiedEmail() {
        return verifiedEmail;
    }

    public void setVerifiedEmail(boolean verified_email) {
        this.verifiedEmail = verified_email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String given_name) {
        this.givenName = given_name;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String family_name) {
        this.familyName = family_name;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Override
    public String toString() {
        return "UserGoogleDto{" +
                "id='" + id + '\'' +
                ", email='" + email + '\'' +
                ", verifiedEmail=" + verifiedEmail +
                ", name='" + name + '\'' +
                ", givenName='" + givenName + '\'' +
                ", familyName='" + familyName + '\'' +
                ", picture='" + picture + '\'' +
                '}';
    }
}