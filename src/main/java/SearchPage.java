import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.List;

public class SearchPage {

    private final WebDriver driver;
    private final WebDriverWait wait;

    /*Locators*/

    private By searchBox = By.name("q");
    private By searchButton = By.xpath("//input[@value=\"Google Search\"]");
    private By searchResults = By.className("rc");

    SearchPage(final WebDriver driver) {
        this.driver = driver;
        this.wait = new WebDriverWait(driver, 30);
    }

    protected void goToURL() {
        this.driver.get("https://www.google.com");
        wait.until(ExpectedConditions.presenceOfElementLocated(searchBox));
    }

    protected void searchForKeyword(String text) throws InterruptedException {
        driver.findElement(searchBox).sendKeys(text);
        wait.until(ExpectedConditions.elementToBeClickable(searchButton));
        driver.findElement(searchButton).click();
        wait.until(ExpectedConditions.presenceOfElementLocated(searchResults));
    }

    protected List<WebElement> getResults() {
        return driver.findElements(searchResults);
    }

}