import * as pulumi from "@pulumi/pulumi";

// Define a dynamic provider that does nothing.
class DummyProvider implements pulumi.dynamic.ResourceProvider {
    async create(inputs: any) {
        return { id: "dummy-id", outs: inputs };
    }
    async update(id: string, olds: any, news: any) {
        return { outs: news };
    }
    async delete(id: string, props: any) {
        // No action needed for delete.
    }
}

// Define a dummy resource using the dynamic provider.
class DummyResource extends pulumi.dynamic.Resource {
    constructor(name: string, props: pulumi.Inputs = {}) {
        super(new DummyProvider(), name, props);
    }
}

// Instantiate the dummy resource.
const dummy = new DummyResource("dummy", {});

// Export an output.
export const dummyId = dummy.id;
