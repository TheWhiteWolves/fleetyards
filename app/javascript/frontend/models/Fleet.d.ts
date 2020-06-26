type Fleet = {
  id: string
  name: string
  myFleet: boolean
}

type FleetForm = {
  fid: string
  rsiSid: string
  name: string
  discord: string
  ts: string
  homepage: string
  twitch: string
  youtube: string
  guilded: string
  removeLogo: boolean
}

interface FleetVehicleParams extends CollectionParams {
  slug: string
  filters: VehicleParams
  grouped: boolean
}

type FleetVehicleStats = {
  total: number
  classifications: ClassificationMetrics
  metrics: VehicleMetrics
}