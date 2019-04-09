<template>
  <div>
    <GitlabRepositories :portfolioId='this.portfolioId'></GitlabRepositories>
  </div>
</template>

<script>
  import GitlabRepositories from './components/gitlab_repositories';

  export default {
    props: ['portfolioId'],
    data() {
      return { }
    },
    components: {
      GitlabRepositories,
    }
  }
</script>
