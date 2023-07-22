describe('Product Details', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000');
  });

  it('should navigate to product details page on click', () => {
    cy.get('.products article').first().click();
    cy.url().should('include', '/products/');
    cy.get('.product-detail').should('be.visible');
  });
});
