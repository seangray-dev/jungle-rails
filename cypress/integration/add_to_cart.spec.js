describe('Add To Cart', () => {
  beforeEach(() => {
    // Setup step to visit the home page
    cy.visit('http://localhost:3000');
  });

  it('should add product to cart and increase cart count', () => {
    // Check the initial count of the cart
    cy.get('a.nav-link').then(($cart) => {
      const initialCount = parseInt($cart.text().match(/\d+/)[0]);

      // Click the 'Add to Cart' button of the first product
      cy.get('.products article')
        .first()
        .find('form.button_to button.btn')
        .click({ force: true });

      // Verify that the cart count has increased by 1
      cy.get('a.nav-link').should(($cart) => {
        const newCount = parseInt($cart.text().match(/\d+/)[0]);
        expect(newCount).to.eq(initialCount + 1);
      });
    });
  });
});
