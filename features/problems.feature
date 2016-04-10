Feature: Problems
  
Scenario: I want to view a problem
  Given I already have the problem "Existing Problem"
  And I am logged in as Admin
  And I am on the problems page
  When I follow "View"
  Then I should be on the problem page for "Existing Problem"
  
Scenario: I want to delete a problem
  Given I already have the problem "Existing Problem"
  And I am logged in as Admin
  And I am on the problems page
  When I follow "Delete"
  Then I should not have any problems
  
Scenario: I want to create a problem
  Given I am logged in as Admin
  And I am on the problems page
  When I follow "New Problem"
  And I fill in "Title" with "Sample Problem"
  And I press "Submit"
  Then I should be on the problem page for "Sample Problem"
  
Scenario: I want to edit an existing problem
  Given I already have the problem "Existing Problem"
  And I am logged in as Admin
  And I am on the problem page for "Existing Problem"
  When I follow "Edit This Problem"
  And I fill in "Skeleton" with "Code Here"
  And I press "Submit"
  Then I should be on the problem page for "Existing Problem"
  And "Existing Problem" should have field skeleton with value "Code Here"
  
Scenario: I want to add a test case to a problem
  Given I already have the problem "Existing Problem"
  And I am logged in as Admin
  And I am on the problems page
  When I follow "View"
  And I follow "New Test Case"
  And I fill in "Input" with "1"
  And I fill in "Output" with "10"
  And I press "Submit"
  Then I should be on the problem page for "Existing Problem"
  And I should see "Input"
  And I should see "Output"

Scenario: I want to edit a test case for a problem
  Given I already have the problem "Existing Problem"
  And the problem "Existing Problem" has a "Existing test case" test case
  And I am logged in as Admin
  And I am on the problems page
  When I follow "View"
  And I follow "Edit Test Case"
  And I fill in "Input" with "Edited Input"
  And I fill in "Output" with "Edited Output"
  And I press "Submit"
  Then I should be on the problem page for "Existing Problem"
  And I should see "Edited Input"
  And I should see "Edited Output"

Scenario: I want to remove a test case for a problem
  Given I already have the problem "Existing Problem"
  And the problem "Existing Problem" has a "Existing test case" test case
  And I am logged in as Admin
  And I am on the problems page
  When I follow "View"
  And I follow "Destroy"
  Then I should be on the problem page for "Existing Problem"
  And I should not see "Edit Test Case"


