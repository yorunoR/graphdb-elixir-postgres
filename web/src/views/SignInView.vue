<template>
  <main class="h-full">
    <div
      class="relative"
      style="top: 30%"
    >
      <div>
        <Button
          @click="signInWithGuest"
        >
          Guest Sign in
        </Button>
        <p>
          ゲストでのサインインでは、作成・更新等のデータ変更を伴う操作ができません。
        </p>
      </div>
      <div>
        <Button
          class="mt-8"
          @click="signIn"
        >
          Google Sign in
        </Button>
        <p>
          Googleでのサインインには、事前登録が必要です。
        </p>
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { useToast } from 'primevue/usetoast'

import { useSigninUserMutation, useSigninGuestMutation } from '@/auto_generated/graphql'
import router from '@/router'
import firebase from '@/services/firebase'

const toast = useToast()

const { executeMutation: signinUser } = useSigninUserMutation()
const { executeMutation: signinGuest } = useSigninGuestMutation()

const signIn = async () => {
  await firebase.signinWithGoogle()
  const result = await signinUser()
  if (result.error) {
    toast.add({
      severity: 'error',
      summary: 'Sign in',
      detail: result.error.message
    })
  } else {
    router.push({ name: 'towers' })
  }
}

const signInWithGuest = async () => {
  await firebase.signinWithGuest()
  const result = await signinGuest()
  if (result.error) {
    toast.add({
      severity: 'error',
      summary: 'Sign in',
      detail: result.error.message
    })
  } else {
    router.push({ name: 'towers' })
  }
}
</script>
