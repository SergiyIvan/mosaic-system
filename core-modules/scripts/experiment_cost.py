SIMULATION_HOURS = 10
SIMULATION_CONC = 10

MICRO_HOURS = 3

c7g_4xlarge_simulation = 0.58 * SIMULATION_HOURS * SIMULATION_CONC
c7a_4xlarge_simulation = 0.82 * SIMULATION_HOURS * SIMULATION_CONC
c7i_4xlarge_simulation = 0.71 * SIMULATION_HOURS * SIMULATION_CONC
c8g_4xlarge_simulation = 0.64 * SIMULATION_HOURS * SIMULATION_CONC
c8a_4xlarge_simulation = 0.86 * SIMULATION_HOURS * SIMULATION_CONC
c8i_4xlarge_simulation = 0.75 * SIMULATION_HOURS * SIMULATION_CONC # 16 vCPU, 32 GB

print("Total for c7g.4xlarge (0.58 USD * {} hours * {} machines): {:.2f} USD".format(SIMULATION_HOURS, SIMULATION_CONC, c7g_4xlarge_simulation))
print("Total for c7a.4xlarge (0.82 USD * {} hours * {} machines): {:.2f} USD".format(SIMULATION_HOURS, SIMULATION_CONC, c7a_4xlarge_simulation))
print("Total for c7i.4xlarge (0.71 USD * {} hours * {} machines): {:.2f} USD".format(SIMULATION_HOURS, SIMULATION_CONC, c7i_4xlarge_simulation))
print("Total for c8g.4xlarge (0.64 USD * {} hours * {} machines): {:.2f} USD".format(SIMULATION_HOURS, SIMULATION_CONC, c8g_4xlarge_simulation))
print("Total for c8a.4xlarge (0.86 USD * {} hours * {} machines): {:.2f} USD".format(SIMULATION_HOURS, SIMULATION_CONC, c8a_4xlarge_simulation))
print("Total for c8i.4xlarge (0.75 USD * {} hours * {} machines): {:.2f} USD".format(SIMULATION_HOURS, SIMULATION_CONC, c8i_4xlarge_simulation))

total_simulation = c7g_4xlarge_simulation+c7a_4xlarge_simulation+c7i_4xlarge_simulation+c8g_4xlarge_simulation+c8a_4xlarge_simulation+c8i_4xlarge_simulation
print("Total for simulation: {:.2f} USD".format(total_simulation))

c8g_xlarge_micro = 0.16 * MICRO_HOURS
c8a_xlarge_micro = 0.22 * MICRO_HOURS
c8i_xlarge_micro = 0.19 * MICRO_HOURS
c7g_xlarge_micro = 0.15 * MICRO_HOURS
c7a_xlarge_micro = 0.21 * MICRO_HOURS
c7i_xlarge_micro = 0.18 * MICRO_HOURS # 4 vCPU, 8 GB

print("Total for c8g.xlarge (0.16 USD * {} hours): {:.2f} USD".format(MICRO_HOURS, c8g_xlarge_micro))
print("Total for c8a.xlarge (0.22 USD * {} hours): {:.2f} USD".format(MICRO_HOURS, c8a_xlarge_micro))
print("Total for c8i.xlarge (0.19 USD * {} hours): {:.2f} USD".format(MICRO_HOURS, c8i_xlarge_micro))
print("Total for c7g.xlarge (0.15 USD * {} hours): {:.2f} USD".format(MICRO_HOURS, c7g_xlarge_micro))
print("Total for c7a.xlarge (0.21 USD * {} hours): {:.2f} USD".format(MICRO_HOURS, c7a_xlarge_micro))
print("Total for c7i.xlarge (0.18 USD * {} hours): {:.2f} USD".format(MICRO_HOURS, c7i_xlarge_micro))

total_micro = c8g_xlarge_micro+c8a_xlarge_micro+c8i_xlarge_micro+c7g_xlarge_micro+c7a_xlarge_micro+c7i_xlarge_micro
print("Total for microbenchmarks: {:.2f} USD".format(total_micro))

total = total_simulation + total_micro
print("Total for all experiments: {:.2f} USD".format(total))
