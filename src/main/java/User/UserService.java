package User;

public class UserService {

	public int join(UserDTO user) {
		UserDAO dao = new UserDAO();
		return dao.join(user);
	}
}