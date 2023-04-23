const CID_KEY = 'cid'

const storage = {
  setCid (value: string) {
    localStorage.setItem(CID_KEY, value)
    return localStorage.getItem(CID_KEY)
  },
  getCid () {
    return localStorage.getItem(CID_KEY) ?? '0'
  }
}

export default storage
