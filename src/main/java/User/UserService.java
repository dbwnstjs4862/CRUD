package User;

public class UserService {

	public boolean join(UserDTO user) {
		UserDAO dao = new UserDAO();
		return dao.join(user) == 1;
	}
}