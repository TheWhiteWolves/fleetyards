import { get } from 'frontend/lib/ApiClient'
import BaseCollection from './Base'

export class ShopsCollection extends BaseCollection {
  records: Shop[] = []

  params: ShopParams | null = null

  async findAll(params: ShopParams): Promise<Shop[]> {
    this.params = params

    const response = await get('shops', {
      q: params.filters,
      page: params.page,
    })

    if (!response.error) {
      this.records = response.data
      this.loaded = true
    }

    this.setPages(response.meta)

    return this.records
  }
}

export default new ShopsCollection()