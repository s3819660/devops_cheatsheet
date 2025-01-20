import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class AccountServiceTest {
    @InjectMock
    private final AccountService accountService = new AccountService();
    
    @Test
    void givenPasswordIsEmpty_shouldThrowException() {
        String email = "s3819660@rmit.edu.vn"; // Valid email
	    String password = ""; // Empty password
        
        // Assert method throws exception
        Exception exception = assertThrow(() -> {
            accountService.registerAccount(email, password);
        });
	    // Assert message produced by sign up method
	    assertEquals("Password cannot be empty or contain only white spaces", exception.getMessage());
    }


    @Test
    void givenEmailIsEmpty_shouldThrowException() {
        String email = "  "; // Email containing only white spaces
	    String password = "&RMIT90sef"; // Valid password
   	    // Assert method throws exception
        Exception exception = assertThrow(() -> {
            accountService.registerAccount(email, password);
        });
        // Assert message produced by sign up method
        assertEquals("Email cannot be empty or contain only white spaces", exception.getMessage());
    }

    @Test
    void givenEmailIsAlreadyRegistered_shouldThrowException() {
        String email = "s3819661@rmit.edu.vn"; // Already registered email
	    String password = "&RMIT90sef”; // Valid password
        // Assert method throws exception
        Exception exception = assertThrow(() -> {
            accountService.registerAccount(email, password);
        });
        // Assert message produced by sign up method
        assertEquals("This email has already been registered. Please choose another email!", exception.getMessage());
    }

    @Test
    void givenPasswordIsWeak_shouldThrowException() {
        String email = "s3819661@rmit.edu.vn"; // Valid email
	    String password = "abc123”; // Weak password
   	    // Assert method throws exception
        Exception exception = assertThrow(() -> {
            accountService.registerAccount(email, password);
        });
        // Assert message produced by sign up method
        assertEquals("Password should contain at least 1 lowercase letter, 1 uppercase letter, 1 digit, 1 special character and should be at least 8 characters in length", exception.getMessage());
    }

    @Test
    void givenEmailIsNotValidPattern_shouldThrowException() {
        String email = "s3819660@rmit ";
	    String password = "&RMIT90sef”;
        // Assert method throws exception
        Exception exception = assertThrow(() -> {
            accountService.registerAccount(email, password);
        });
        // Assert message produced by sign up method
	    assertEquals("You have entered an invalid email. Email should be of format: abc@rmit.edu.vn", exception.getMessage());
    }
}