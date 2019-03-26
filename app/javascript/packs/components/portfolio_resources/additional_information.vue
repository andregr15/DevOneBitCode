<template>
  <div class="bloco-informacoes-adicionais">
    <h4 class="block-title grey">Informações Adicionais</h4>

    <div class="input-field col l12 m12 s12">
      <input type="text" id="additional-information-title" v-model="additional_information.title" 
              @change="submit()" class="font_20 custom-grey-text text-darken-1" />
      <label for="additional-information-title" class="font_20 custom-grey-text text-darken-1 active">Título</label>
    </div>

    <div class="row">
      <div class="input-field col l12 s12 m12">
        <vue-ckeditor v-model="additional_information.description" :config="config" @blur="submit()"/>
      </div>
    </div>
  </div>
</template>

<script>
  import VueCkeditor from 'vue-ckeditor2';

  export default {
    components: { VueCkeditor },

    props: ['portfolioId', 'blockId'],

    data() {
      return {
        additional_information: { 
          title: '',
          description: ' '
        },
        config: {
          toolbar: [ 
            [
              'Bold', 'Italic', 'Underline1', 'Strike', 'Subscript', 'Superscript', 
              'RemoveFormat', 'Cut', 'Copy', 'Paste', 'Undo', 'Redo'
            ]
          ],
          height: 150
        }
      }
    },

    created() {
      this.$resource('/portfolios{/portfolioId}/blocks{/blockId}/additional_informations')
          .get({
            portfolioId: this.portfolioId,
            blockId: this.blockId
          }).then(
            response => this.additional_information = response.body.resource,
            error => M.toast({
              html: "Ocorreu um erro ao tentar carregar as Informações Adicionais",
              classes: "red"
            })
          );
    },

    methods: {
      submit() {
        this.$resource('/portfolios{/portfolioId}/blocks{/blockId}/additional_informations{/id}')
            .update(
              {
                portfolioId: this.portfolioId,
                blockId: this.blockId,
                id: this.additional_information.id
              },
              {
                additional_information: this.additional_information
              }
            ).then(
              {},
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

