<template>
  <div class="bloco-contato center">
    <h4 class="block-title grey">Contato</h4>

    <div class="row">
      <div class="input-field col s12">
        <input type="email" class="font_20 custom-grey-text text-darken-1" id="contact-email" v-model="contact.email" required/>
        <label for="contact-email" class="active font_20 custom-grey-text text-darken-1">E-mail</label>
      </div>

      <div class="input-field col s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1" id="contact-phone" v-model="contact.phone" required/>
        <label for="contact-phone" class="active font_20 custom-grey-text text-darken-1">Telefone</label>
      </div>

      <div class="input-field col s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1" id="contact-website" v-model="contact.website" />
        <label for="contact-website" class="active font_20 custom-grey-text text-darken-1">Website</label>
      </div>

      <div class="input-field col s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1" id="contact-address-country" v-model="contact.address_country" />
        <label for="contact-address-country" class="active font_20 custom-grey-text text-darken-1">País</label>
      </div>

      <div class="input-field col s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1" id="contact-address-city" v-model="contact.address_city" />
        <label for="contact-address-city" class="active font_20 custom-grey-text text-darken-1">Cidade</label>
      </div>

      <div class="input-field col s12">
        <button type="button" class="btn" id="save-contact" @click="submit()">Salvar</button>
      </div>
    </div>
  </div>
</template>

<script>
  export default{
    props: ['portfolioId'],

    data() {
      return {
        contact: {
        }
      }
    },

    created() {
      this.$resource('/portfolios{/portfolioId}/contacts')
          .get({ portfolioId: this.portfolioId })
          .then(
            response => this.contact = response.body.resource,
            error => M.toast({
              html: "Ocorreu um erro ao carregar os dados de Contato",
              classes: "red"
            })
          );
    },

    methods: {
      submit() {
        this.$resource('/portfolios{/portfolioId}/contacts{/id}')
            .update({
              portfolioId: this.portfolioId,
              id: this.contact.id
            }, {
              contact: this.contact
            }).then(
              response => M.toast({
                html: "Dados do contato salvo com sucesso!",
                classes: "green"
              }),
              error => error.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      }
    }

  }
</script>
