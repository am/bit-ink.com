describe('The Home Page', function() {
  it('successfully loads', function() {
    cy.visit('/')
  })

  it('should display homepage content', function() {
    cy.get('h1').should('contain', 'bit-ink')
  })
})
