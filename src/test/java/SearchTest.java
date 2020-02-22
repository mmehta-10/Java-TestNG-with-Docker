import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;


public class SearchTest {

    private WebDriver driver;
    private SearchPage google;

    @BeforeTest
    public void setUp() {
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        google = new SearchPage(driver);
    }

    @Test
    public void googleTest() throws InterruptedException {
        google.goToURL();
        google.searchForKeyword("automation");
        Assert.assertTrue(google.getResults().size() >= 10);
    }

    @AfterTest
    public void tearDown() {
        driver.quit();
    }

}