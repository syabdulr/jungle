describe('Home Page', () => {
  it('successfully loads', () => {
    cy.visit('/') // Visit the root URL
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});
