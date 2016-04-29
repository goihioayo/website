package shopApp;

public class User {
	private String name;
	private String role;
	private Integer age;
	private String state;
	public User(String name, String role, Integer age, String state) {
		this.name = name;
		this.role = role;
		this.age = age;
		this.state = state;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
}
